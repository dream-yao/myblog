# coding:utf-8
from flask.ext.wtf import Form
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import Required, Length, Email, EqualTo, Regexp
from wtforms import ValidationError
from app.models import User
from flask.ext.pagedown.fields import PageDownField

class LoginForm(Form):
    username = StringField('Enter your name', validators=[Required()])
    password = PasswordField('Password', validators=[Required()])
    remember_me = BooleanField('Keep me logined in')
    submit = SubmitField('Login')


class PostForm(Form):
    title=StringField("Title",validators=[Required()])
    body = PageDownField("What's on your mind?", validators=[Required()])
    category=StringField("CATEGORY",validators=[Required()])
    submit = SubmitField('Submit')


class EditForm(Form):
    title=StringField("Title",validators=[Required()])
    body = PageDownField("What's on your mind?", validators=[Required()])
    category=StringField("CATEGORY",validators=[Required()])
    submit = SubmitField('Submit')