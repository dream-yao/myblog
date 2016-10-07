#!/usr/bin/python
# coding: utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

import os 
from app import create_app, db 
from app.models import User, Post, Category, Tie
from flask.ext.script import Manager, Shell 
from flask.ext.migrate import Migrate, MigrateCommand

app=create_app('default')
manager=Manager(app)
migrate=Migrate(app,db)

def make_shell_context():
	return dict(app=app, db=db, User=User, Post=Post, Category=Category, Tie=Tie)
@manager.command
def test():
	"""Run the unit tests"""
	import unittest 
	tests = unittest.TestLoader().discover('tests')
	unittest.TextTestRunner(verbosity=2).run(tests)
<<<<<<< HEAD
	manager.add_command("shell", Shell(make_context=make_shell_context))
	manager.add_command("db", MigrateCommand)
=======
manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command("db", MigrateCommand)
>>>>>>> 44a0ed4adc99a4c112858a1046f85a2852d459b7

if __name__ == '__main__':
	manager.run()


