#!/usr/bin/python
#coding: utf-8
import os 
from app import create_app, db 
from app.models import User, Post, Category, Tie
from flask.ext.script import Manager, Shell 
from flask.ext.migrate import Migrate, MigrateCommand
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

app=create_app('default')
manager=Manager(app)
migrate=Migrate(app,db)
@manager.command
def test():
    """Run the unit tests"""
    import unittest 
    tests = unittest.TestLoader().discover('tests')
    unittest.TextTestRunner(verbosity=2).run(tests) 

def make_shell_context():
    return dict(app=app, db=db, User=User, Post=Post, Category=Category, Tie=Tie)
manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command("db", MigrateCommand)


if __name__ == '__main__':
	manager.run()


