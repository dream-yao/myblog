-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: smy
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('afae307ce327');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorys`
--

DROP TABLE IF EXISTS `categorys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(64) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorys`
--

LOCK TABLES `categorys` WRITE;
/*!40000 ALTER TABLE `categorys` DISABLE KEYS */;
INSERT INTO `categorys` VALUES (1,'Python',7),(2,'Html5',2);
/*!40000 ALTER TABLE `categorys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `body` text,
  `timestamp` datetime DEFAULT NULL,
  `body_html` text,
  PRIMARY KEY (`id`),
  KEY `ix_posts_timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'第一篇博文','Hello','2016-09-16 03:50:35','<p>Hello</p>'),(2,'第一篇博文','Hello','2016-09-16 03:50:35','<p>Hello</p>'),(5,'jdisao','dsada','2016-09-16 07:01:22','<p>dsada</p>'),(6,'如43让','认为二人','2016-09-16 07:01:59','<p>认为二人</p>'),(7,'测试博文','成功！','2016-09-16 08:35:07','<p>成功！</p>'),(8,'再次测试','你好','2016-09-17 02:31:08','<p>你好</p>'),(9,'发生的发生','发生的发生','2016-09-17 02:37:40','<p>发生的发生</p>'),(12,'测试','最近特别忙很久没更博了。。。。那就写一篇还算很干货的吧。\r\n\r\n因为最近写了个基于gevent的python的web框架，所以写一篇简单博文，讲讲这个东西的设计。\r\n\r\n其实总的来说，虽同是动态语言，不同于ruby方面ruby on rails一枝独秀（我知道还有sinatra），而反观py这边，各个框架各领风骚，大而全的有Django，小而美的有 flask , bottle，要性能的有tornado（虽然这货“啥”都有。。）,以及极致简单，被guido叔称赞为最pythonic的webpy, 那么为什么py领域的web框架这个之多呢？\r\n\r\n首先要说明的是，py领域的web框架就我的使用体验来说，和ruby on rails相比还是有点差距的，这张图可以说明一下。\r\n\r\npic\r\n\r\n可以看出，py领域还是不那么风骚，而且rails都要出5.0 version了，django才刚刚1.9。\r\n\r\n但是不否认django是个优秀的框架，不然类似pinterest和instagram这种神牛公司怎么会用它呢？\r\n\r\nWSGI\r\n要写一个py的web框架，就必须要理解wsgi.\r\n\r\n那么什么是wsgi呢？\r\n\r\n这里是官网给他的解释（wsgi是pep 333规范里面）\r\n\r\nWSGI is the Web Server Gateway Interface. It is a specification that describes how a web server communicates with web applications, and how web applications can be chained together to process one request.\r\n翻译过来就是，这个东西做了个嫁接层，网络通信基本是基于http协议，而http 协议是基于TCP协议的。\r\n\r\n这里好冗长，，，而对于暂时我们就先不管什么TCP协议，在这之上我们使用socket 做网络协议。\r\n\r\n上面这段话对我们有用的，总结起来就是，wsgi 包装了socket的东西，使之能与py的application做网络交互（如你的socket网络层可以是c写的，但是你暴露出socket来，我可以对他基于wsgi协议写个py层）\r\n\r\n对wsgi 详情感兴趣的同学可以看 这里\r\n\r\n以上的东西，暂时对我们的框架理解没太大的影响，你可以理解为wsgi是个黑盒子，它暴露出了很多东西，让你你能去操作你要的事情\r\n\r\n我们来看看他暴露了什么\r\n\r\n在py的标准库里面有一个wsgi叫wsgiref ,我们基于他写个最简单的application:\r\n\r\n    from wsgiref.simple_server import make_server\r\n\r\n    def simple_app(environ, start_response):\r\n        \"\"\"Simplest possible application object\"\"\"\r\n        status = \'200 OK\'\r\n        response_headers = [(\'Content-type\', \'text/plain\')]\r\n        start_response(status, response_headers)\r\n        return [\'Hello world!\\n\']\r\n\r\n    app=make_server(\'127.0.0.1\',8000,simple_app)\r\n    app.serve_forever()\r\n好的，这个时候我们跑这个程序，然后在terminal 输入：http http://127.0.0.1:8000\r\n\r\n可以看到：\r\n\r\n    aljundeMacBook-Pro:~ aljun$ http http://127.0.0.1:8000\r\n    HTTP/1.0 200 OK\r\n    Content-Length: 13\r\n    Content-type: text/plain\r\n    Date: Fri, 03 Jun 2016 08:32:55 GMT\r\n    Server: WSGIServer/0.1 Python/2.7.11\r\n\r\n    Hello world!\r\n好的，我们这里看到你的simple_app里面有两个参数，这个是wsgi协议里面规定的两个。\r\n\r\n首先是environ这个参数，这个参数包括很多环境参数。\r\n\r\n官方对他的解释为：\r\n\r\nThe environ dictionary is required to contain these CGI environment variables, as defined by the Common Gateway Interface specification\r\n我们更改下刚刚的程序，看看有写什么参数：\r\n\r\n    from wsgiref.simple_server import make_server\r\n\r\n    def simple_app(environ, start_response):\r\n        \"\"\"Simplest possible application object\"\"\"\r\n        status = \'200 OK\'\r\n        response_headers = [(\'Content-type\', \'text/plain\')]\r\n        start_response(status, response_headers)\r\n        for key,value in environ.items():\r\n            print key,value\r\n        return [\'Hello world!\\n\']\r\n\r\n    app=make_server(\'127.0.0.1\',8000,simple_app)\r\n    app.serve_forever()\r\n可以得到，我们的environ参数：\r\n\r\n    rvm_version 1.26.11 (latest)\r\n    SERVER_PROTOCOL HTTP/1.1\r\n    SERVER_SOFTWARE WSGIServer/0.1 Python/2.7.11\r\n    rvm_path /Users/aljun/.rvm\r\n    TERM_PROGRAM_VERSION 361.1\r\n    REQUEST_METHOD GET\r\n    LOGNAME aljun\r\n    USER aljun\r\n    HOME /Users/aljun\r\n    QUERY_STRING \r\n    PATH /Users/aljun/anaconda2/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Users/aljun/.rvm/bin\r\n    wsgi.errors <open file \'<stderr>\', mode \'w\' at 0x1002a61e0>\r\n    TERM_PROGRAM Apple_Terminal\r\n    LANG zh_CN.UTF-8\r\n    TERM xterm-256color\r\n    SHELL /bin/bash\r\n    HTTP_CONNECTION keep-alive\r\n    SERVER_NAME 1.0.0.127.in-addr.arpa\r\n    REMOTE_ADDR 127.0.0.1\r\n    SHLVL 1\r\n    PWD /Users/aljun/example\r\n    XPC_FLAGS 0x0\r\n    wsgi.url_scheme http\r\n    _ /Users/aljun/anaconda2/bin/python\r\n    SERVER_PORT 8000\r\n    _system_arch x86_64\r\n    rvm_bin_path /Users/aljun/.rvm/bin\r\n    CONTENT_LENGTH \r\n    TERM_SESSION_ID 221B75E7-EC58-4152-B581-0CB21C2B1C72\r\n    XPC_SERVICE_NAME 0\r\n    CONTENT_TYPE text/plain\r\n    rvm_prefix /Users/aljun\r\n    SSH_AUTH_SOCK /private/tmp/com.apple.launchd.VOLZRZ7eY6/Listeners\r\n    _system_type Darwin\r\n    wsgi.input <socket._fileobject object at 0x1006cf950>\r\n    Apple_PubSub_Socket_Render /private/tmp/com.apple.launchd.RPrxYoySso/Render\r\n    HTTP_HOST 127.0.0.1:8000\r\n    SCRIPT_NAME \r\n    wsgi.multithread True\r\n    TMPDIR /var/folders/df/cw8ny49n25vb0z0_0wp3yvt80000gn/T/\r\n    HTTP_ACCEPT */*\r\n    wsgi.version (1, 0)\r\n    HTTP_USER_AGENT HTTPie/0.9.3\r\n    GATEWAY_INTERFACE CGI/1.1\r\n    wsgi.run_once False\r\n    OLDPWD /Users/aljun\r\n    wsgi.multiprocess False\r\n    __CF_USER_TEXT_ENCODING 0x1F5:0x19:0x34\r\n    _system_name OSX\r\n    _system_version 10.11\r\n    wsgi.file_wrapper wsgiref.util.FileWrapper\r\n    REMOTE_HOST 1.0.0.127.in-addr.arpa\r\n    HTTP_ACCEPT_ENCODING gzip, deflate\r\n    PATH_INFO /\r\n可以看到非常多，这里说明一下wsgi.input 就是我们的表单传值\r\n\r\n可以看到我们做web通常需要的PATH_INFO，HTTP_USER_AGENT,QUERY_STRING,REQUEST_METHOD,SERVER_PROTOCAOL都在里面了\r\n\r\n即是说，这个environ参数给我提供了我们要的网络的所有环境参数\r\n\r\n而对于start_response这个参数，官方的说明是：\r\n\r\nThe second parameter passed to the application object is a callable of the form startresponse(status, responseheaders, exc_info=None)\r\n他基本上要两个参数，一个是状态，即是HTTP状态，例如我们这个程序的200 OK，一个是response_header即是我们传给client端的header，例如我们这里加了一个(\'Content-type\', \'text/plain\')\r\n\r\n最后，是你返回的（return）的东西，可以是html也可以是json等等，这次我们返回了一个hello world。\r\n\r\n那么，你理解了wsgi在干什么，写一个web框架就真的易如反掌了。\r\n\r\n实现一个web框架','2016-09-17 05:01:48','<p>最近特别忙很久没更博了。。。。那就写一篇还算很干货的吧。</p>\n<p>因为最近写了个基于gevent的python的web框架，所以写一篇简单博文，讲讲这个东西的设计。</p>\n<p>其实总的来说，虽同是动态语言，不同于ruby方面ruby on rails一枝独秀（我知道还有sinatra），而反观py这边，各个框架各领风骚，大而全的有Django，小而美的有 flask , bottle，要性能的有tornado（虽然这货“啥”都有。。）,以及极致简单，被guido叔称赞为最pythonic的webpy, 那么为什么py领域的web框架这个之多呢？</p>\n<p>首先要说明的是，py领域的web框架就我的使用体验来说，和ruby on rails相比还是有点差距的，这张图可以说明一下。</p>\n<p>pic</p>\n<p>可以看出，py领域还是不那么风骚，而且rails都要出5.0 version了，django才刚刚1.9。</p>\n<p>但是不否认django是个优秀的框架，不然类似pinterest和instagram这种神牛公司怎么会用它呢？</p>\n<p>WSGI\n要写一个py的web框架，就必须要理解wsgi.</p>\n<p>那么什么是wsgi呢？</p>\n<p>这里是官网给他的解释（wsgi是pep 333规范里面）</p>\n<p>WSGI is the Web Server Gateway Interface. It is a specification that describes how a web server communicates with web applications, and how web applications can be chained together to process one request.\n翻译过来就是，这个东西做了个嫁接层，网络通信基本是基于http协议，而http 协议是基于TCP协议的。</p>\n<p>这里好冗长，，，而对于暂时我们就先不管什么TCP协议，在这之上我们使用socket 做网络协议。</p>\n<p>上面这段话对我们有用的，总结起来就是，wsgi 包装了socket的东西，使之能与py的application做网络交互（如你的socket网络层可以是c写的，但是你暴露出socket来，我可以对他基于wsgi协议写个py层）</p>\n<p>对wsgi 详情感兴趣的同学可以看 这里</p>\n<p>以上的东西，暂时对我们的框架理解没太大的影响，你可以理解为wsgi是个黑盒子，它暴露出了很多东西，让你你能去操作你要的事情</p>\n<p>我们来看看他暴露了什么</p>\n<p>在py的标准库里面有一个wsgi叫wsgiref ,我们基于他写个最简单的application:</p>\n<pre><code>from wsgiref.simple_server import make_server\n\ndef simple_app(environ, start_response):\n    \"\"\"Simplest possible application object\"\"\"\n    status = \'200 OK\'\n    response_headers = [(\'Content-type\', \'text/plain\')]\n    start_response(status, response_headers)\n    return [\'Hello world!\\n\']\n\napp=make_server(\'127.0.0.1\',8000,simple_app)\napp.serve_forever()\n</code></pre>\n<p>好的，这个时候我们跑这个程序，然后在terminal 输入：http http://127.0.0.1:8000</p>\n<p>可以看到：</p>\n<pre><code>aljundeMacBook-Pro:~ aljun$ http http://127.0.0.1:8000\nHTTP/1.0 200 OK\nContent-Length: 13\nContent-type: text/plain\nDate: Fri, 03 Jun 2016 08:32:55 GMT\nServer: WSGIServer/0.1 Python/2.7.11\n\nHello world!\n</code></pre>\n<p>好的，我们这里看到你的simple_app里面有两个参数，这个是wsgi协议里面规定的两个。</p>\n<p>首先是environ这个参数，这个参数包括很多环境参数。</p>\n<p>官方对他的解释为：</p>\n<p>The environ dictionary is required to contain these CGI environment variables, as defined by the Common Gateway Interface specification\n我们更改下刚刚的程序，看看有写什么参数：</p>\n<pre><code>from wsgiref.simple_server import make_server\n\ndef simple_app(environ, start_response):\n    \"\"\"Simplest possible application object\"\"\"\n    status = \'200 OK\'\n    response_headers = [(\'Content-type\', \'text/plain\')]\n    start_response(status, response_headers)\n    for key,value in environ.items():\n        print key,value\n    return [\'Hello world!\\n\']\n\napp=make_server(\'127.0.0.1\',8000,simple_app)\napp.serve_forever()\n</code></pre>\n<p>可以得到，我们的environ参数：</p>\n<pre><code>rvm_version 1.26.11 (latest)\nSERVER_PROTOCOL HTTP/1.1\nSERVER_SOFTWARE WSGIServer/0.1 Python/2.7.11\nrvm_path /Users/aljun/.rvm\nTERM_PROGRAM_VERSION 361.1\nREQUEST_METHOD GET\nLOGNAME aljun\nUSER aljun\nHOME /Users/aljun\nQUERY_STRING \nPATH /Users/aljun/anaconda2/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Users/aljun/.rvm/bin\nwsgi.errors &lt;open file=\"\" \'&lt;stderr=\"\"&gt;\', mode \'w\' at 0x1002a61e0&gt;\nTERM_PROGRAM Apple_Terminal\nLANG zh_CN.UTF-8\nTERM xterm-256color\nSHELL /bin/bash\nHTTP_CONNECTION keep-alive\nSERVER_NAME <a href=\"http://1.0.0.127.in-addr.arpa\" rel=\"nofollow\">1.0.0.127.in-addr.arpa</a>\nREMOTE_ADDR 127.0.0.1\nSHLVL 1\nPWD /Users/aljun/example\nXPC_FLAGS 0x0\nwsgi.url_scheme http\n_ /Users/aljun/anaconda2/bin/python\nSERVER_PORT 8000\n_system_arch x86_64\nrvm_bin_path /Users/aljun/.rvm/bin\nCONTENT_LENGTH \nTERM_SESSION_ID 221B75E7-EC58-4152-B581-0CB21C2B1C72\nXPC_SERVICE_NAME 0\nCONTENT_TYPE text/plain\nrvm_prefix /Users/aljun\nSSH_AUTH_SOCK /private/tmp/com.apple.launchd.VOLZRZ7eY6/Listeners\n_system_type Darwin\nwsgi.input &lt;socket._fileobject object=\"\" at=\"\" 0x1006cf950=\"\"&gt;\nApple_PubSub_Socket_Render /private/tmp/com.apple.launchd.RPrxYoySso/Render\nHTTP_HOST 127.0.0.1:8000\nSCRIPT_NAME \nwsgi.multithread True\nTMPDIR /var/folders/df/cw8ny49n25vb0z0_0wp3yvt80000gn/T/\nHTTP_ACCEPT */*\nwsgi.version (1, 0)\nHTTP_USER_AGENT HTTPie/0.9.3\nGATEWAY_INTERFACE CGI/1.1\nwsgi.run_once False\nOLDPWD /Users/aljun\nwsgi.multiprocess False\n__CF_USER_TEXT_ENCODING 0x1F5:0x19:0x34\n_system_name OSX\n_system_version 10.11\nwsgi.file_wrapper wsgiref.util.FileWrapper\nREMOTE_HOST <a href=\"http://1.0.0.127.in-addr.arpa\" rel=\"nofollow\">1.0.0.127.in-addr.arpa</a>\nHTTP_ACCEPT_ENCODING gzip, deflate\nPATH_INFO /\n</code></pre>\n<p>可以看到非常多，这里说明一下wsgi.input 就是我们的表单传值</p>\n<p>可以看到我们做web通常需要的PATH_INFO，HTTP_USER_AGENT,QUERY_STRING,REQUEST_METHOD,SERVER_PROTOCAOL都在里面了</p>\n<p>即是说，这个environ参数给我提供了我们要的网络的所有环境参数</p>\n<p>而对于start_response这个参数，官方的说明是：</p>\n<p>The second parameter passed to the application object is a callable of the form startresponse(status, responseheaders, exc_info=None)\n他基本上要两个参数，一个是状态，即是HTTP状态，例如我们这个程序的200 OK，一个是response_header即是我们传给client端的header，例如我们这里加了一个(\'Content-type\', \'text/plain\')</p>\n<p>最后，是你返回的（return）的东西，可以是html也可以是json等等，这次我们返回了一个hello world。</p>\n<p>那么，你理解了wsgi在干什么，写一个web框架就真的易如反掌了。</p>\n<p>实现一个web框架</p>'),(29,'富文本测试','成功','2016-10-06 06:02:10','<p>成功</p>'),(30,'没有框架','测试测试','2016-10-06 06:04:39','<p>测试</p>'),(31,'有框架','write有框架，edit没有框架','2016-10-06 06:24:43','<p>write有框架，edit没有框架</p>'),(32,'测试','都有框架','2016-10-06 06:26:03','<p>都有框架</p>'),(34,'你好','产生的方式的 ','2016-10-06 07:38:42','<p>产生的方式的 </p>'),(38,'手机测试','成功','2016-10-06 11:07:41','<p>成功</p>');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ties`
--

DROP TABLE IF EXISTS `ties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `cate_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `ties_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `categorys` (`id`),
  CONSTRAINT `ties_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ties`
--

LOCK TABLES `ties` WRITE;
/*!40000 ALTER TABLE `ties` DISABLE KEYS */;
INSERT INTO `ties` VALUES (1,12,1),(23,29,1),(24,29,2),(40,30,1),(41,30,2),(44,31,1),(61,32,1),(62,34,1),(67,38,1);
/*!40000 ALTER TABLE `ties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `password_hash` (`password_hash`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'sun','pbkdf2:sha1:1000$v8bs9542$fd4c99ec9eba56f29bf2b5cab1533fcf5d1ae984');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-07 16:47:22
