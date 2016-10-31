# coding: utf-8
from . import db
from werkzeug.security import generate_password_hash, check_password_hash
from . import login_manager
from flask.ext.login import UserMixin
from flask import current_app, request
from datetime import datetime
import hashlib
from markdown import markdown
import bleach


class User(UserMixin, db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), unique=True)
    password_hash = db.Column(db.String(128), unique=True)

    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class Post(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.Text)
    body = db.Column(db.Text)
    timestamp = db.Column(db.DateTime, index=True, default=datetime.utcnow)
    body_html = db.Column(db.Text)
    # category_id = db.Column(db.Integer, db.ForeignKey('categorys.id'))
    tie_post = db.relationship(
        "Tie", backref="pos", lazy='dynamic', passive_deletes=True)

    @staticmethod
    def on_changed_body(target, value, oldvalue, initiator):
        allowed_tags = ['a', 'abbr', 'acronym', 'b', 'blockquote', 'code',
                        'em', 'i', 'li', 'ol', 'pre', 'strong', 'ul',
                        'h1', 'h2', 'h3', 'p']
        target.body_html = bleach.linkify(bleach.clean(
            markdown(value, output_format='html'),
            tags=allowed_tags, strip=True))
db.event.listen(Post.body, 'set', Post.on_changed_body)



class Category(db.Model):
    __tablename__ = "categorys"
    id = db.Column(db.Integer, primary_key=True)
    tag = db.Column(db.String(64), unique=True)
    count = db.Column(db.Integer)
    # posts = db.relationship("Post", backref="category", lazy='dynamic')
    tie_cate = db.relationship("Tie", backref="category", lazy='dynamic')

# db.event.listen(Category.count, 'set', Category.leng())
class Tie(db.Model):
    __tablename__ = "ties"
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('posts.id', ondelete='CASCADE'))
    cate_id = db.Column(db.Integer, db.ForeignKey('categorys.id'))

    

