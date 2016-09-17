# coding:utf-8
from . import main
from .. import db
from app.models import User, Post, Category, Tie
from .forms import LoginForm, PostForm, EditForm
from flask import render_template, redirect, url_for, flash, request
from flask.ext.login import login_user, logout_user, current_user, login_required


@main.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    pagination = Post.query.order_by(Post.timestamp.desc()).paginate(
        page, per_page=8, error_out=False)
    posts = pagination.items
    # tie = []
    # for i in posts:
    # ties.append(Tie.query.filter_by(post_id=i.id).all())
    ties = Tie.query.all()
    cates = Category.query.all()
    return render_template('index.html', posts=posts, pagination=pagination, ties=ties, cates=cates)


@main.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm(request.form)
    if form.validate_on_submit():
        # if request.method == "POST" and form.validate():
        # if request.method == "POST":
        flash("zhengque")
        u = User.query.filter_by(username=form.username.data).first()
        if u is not None and u.verify_password(form.password.data):
            login_user(u, form.remember_me.data)
            return redirect(request.args.get('next') or url_for('main.index'))
        flash('Please check your email or password')
        # return redirect(request.args.get('next') or url_for('main.index'))
    return render_template('login.html', form=form)


@main.route('/logout')
@login_required
def logout():
    logout_user()
    # 竟然不需要加current_user
    flash("Logout Success")
    return redirect(url_for('main.index'))


@main.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@main.errorhandler(500)
def internal_server_error(e):
    return render_template('500.html'), 500


@main.route('/writepost', methods=['GET', 'POST'])
@login_required
def writepost():
    form = PostForm(request.form)
    cate = Category.query.all()
    if form.validate_on_submit():
        # fo = form.category.data.split(',')
        # for i in fo[0:-1]:
        #     c = Category.query.filter_by(tag=i).first()
        #     if c is not None:
        #         pos = Post(title=form.title.data, body=form.body.data, category_id=c.id)
        #         db.session.add(pos)
        # db.session.commit()
        # return redirect(url_for('main.index'))
        pos = Post(title=form.title.data, body=form.body.data)
        db.session.add(pos)
        fo = form.category.data.split(',')
        for i in fo[0:-1]:
            c = Category.query.filter_by(tag=i).first()
            if c is not None:
                tie = Tie(post_id=pos.id, cate_id=c.id)
                db.session.add(tie)
        for ca in cate:
            ca.count = Tie.query.filter(Tie.cate_id == ca.id).count()
        db.session.commit()
        return redirect(url_for('main.index'))
    return render_template('writepost.html', form=form, the_category=cate)


@main.route('/post/<id>')
def post(id):
    post = Post.query.get_or_404(id)
    ties = Tie.query.filter_by(post_id=id).all()
    return render_template('posts.html', post=post, ties=ties)


@main.route('/category/<tag>')
def category(tag):
    ties = Tie.query.all()
    category = Category.query.all()
    page = request.args.get('page', 1, type=int)
    # session.query(User, Address).filter(User.id == Address.user_id)
    # 三表连接查询
    pos = Post.query.join(Tie).join(Category).filter(Category.tag == tag)
    pagination = pos.order_by(Post.timestamp.desc()).paginate(
        page, per_page=8, error_out=False)
    posts = pagination.items
    cates = Category.query.all()
    return render_template('index.html', posts=posts, pagination=pagination, ties=ties, cates=cates)


@main.route('/editpost/<id>', methods=['GET', 'POST'])
def edit(id):
    form = EditForm(request.form)
    cate = Category.query.all()
    po = Post.query.filter(Post.id == id).first()
    if form.validate_on_submit():
        # fo = form.category.data.split(',')
        # for i in fo[0:-1]:
        #     c = Category.query.filter_by(tag=i).first()
        #     if c is not None:
        #         pos = Post(title=form.title.data, body=form.body.data, category_id=c.id)
        #         db.session.add(pos)
        # db.session.commit()
        # return redirect(url_for('main.index'))
        pos = Post(title=form.title.data, body=form.body.data)
        db.session.add(pos)
        fo = form.category.data.split(',')
        for i in fo[0:-1]:
            c = Category.query.filter_by(tag=i).first()
            if c is not None:
                tie = Tie(post_id=pos.id, cate_id=c.id)
                db.session.add(tie)
        for ca in cate:
            ca.count = Tie.query.filter(Tie.cate_id == ca.id).count()
        db.session.commit()
        return redirect(url_for('main.index'))

    form.title.data = po.title
    form.body.data = po.body
    poss = Category.query.join(Tie).join(Post).filter(Post.id == id).all()
    for pos in poss:
        form.category.data = str(form.category.data) + str(pos.tag) + ','
        # pos.tag返回的是unicode值
    return render_template('editpost.html', form=form, the_category=cate)


@main.route('/deletepost/<id>', methods=['GET', 'POST'])
def delete(id):
    post = Post.query.filter(Post.id == id).first()
    db.session.delete(post)
    db.session.commit()
    return redirect(url_for('main.index'))
