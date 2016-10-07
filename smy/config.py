#!/usr/bin/python
# coding: utf-8
import os 
basedir=os.path.abspath(os.path.dirname(__file__))

class Config:
	SECRET_KEY = os.environ.get('SECRET_KEY') or 'hard to guess something'
	SSL_DISABLE = False
	SQLALCHEMY_COMMIT_ON_TEARDOWN = True
	SQLALCHEMY_RECORD_QUENIES = True
	SQLALCHEMY_TRACK_MODIFICATIONS = False
	SQLALCHEMY_DATABASE_URI = 'mysql://root:123456@localhost/smy'
	DEBUG = True

	FLASKY_POSTS_PER_PAGE = 10
	FLASKY_FOLLOWERS_PER_PAGE = 20
<<<<<<< HEAD
	FLASKY_COMMENTS_PER_PAGE = 5
=======
	#FLASKY_COMMENTS_PER_PAGE = 5
>>>>>>> 44a0ed4adc99a4c112858a1046f85a2852d459b7
	@staticmethod
	def init_app(app):
		pass


