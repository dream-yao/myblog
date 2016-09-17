# coding: utf-8


from flask import Flask, render_template
from flask.ext.moment import Moment
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import LoginManager
from flask.ext.pagedown import PageDown
from config import Config


moment = Moment()
db = SQLAlchemy()
pagedown = PageDown()
login_manager = LoginManager()
# 设置用户会话安全等级
login_manager.session_protection = 'strong'
# 设置登录页面端点
login_manager.login_view = 'main.login'


def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(Config)

    Config.init_app(app)
    moment.init_app(app)
    db.init_app(app)
    login_manager.init_app(app)
    pagedown.init_app(app)

    # 附加路由和自定义的错误界面

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app
