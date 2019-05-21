# openstack_test

Requirements:<br />
	* Operating System shouldn't matter: I'm using Fedora and Gentoo<br />
	* `yum install ruby git`<br />
	* `gem install fog-openstack`<br />
	* Populate contents of 'connection.json' with your API key<br /><br />

This is what output of the script should look like if it can successfully connecto to OpenStack/DHC and gather the count of instances and security groups in the account:

```
$ ./openstack_test.rb
Conecting to OpenStack: https://iad2.dream.io:5000/
Successfully connected to OpenStack!
Checking instance count...
Instance Count: 7
Checking security group count...
Security Group Count: 9
---------------------------
```

While I do have timeouts set in the script, those can be removed or increased if needed for your tests, but on a working system like my laptop, 3 seconds has been sufficient to allow the calls to complete.

To test on my instance, I run it in a loop passing stderr to /dev/null since it will get messy:

```
[fedora@fedora-test-1 ~]$ while true ; do ./openstack_test.rb 2>/dev/null  ; done
Conecting to OpenStack: https://iad2.dream.io:5000/
Successfully connected to OpenStack!
Checking instance count...
Conecting to OpenStack: https://iad2.dream.io:5000/
Conecting to OpenStack: https://iad2.dream.io:5000/
Conecting to OpenStack: https://iad2.dream.io:5000/
Successfully connected to OpenStack!
Checking instance count...
Instance Count: 7
Checking security group count...
Conecting to OpenStack: https://iad2.dream.io:5000/
Successfully connected to OpenStack!
Checking instance count...
Conecting to OpenStack: https://iad2.dream.io:5000/
Conecting to OpenStack: https://iad2.dream.io:5000/
Conecting to OpenStack: https://iad2.dream.io:5000/
Conecting to OpenStack: https://iad2.dream.io:5000/
^C
```

In the test loop here, it shows that occasionally it can connect to authentication (port:5000) and even less frequently can view instances (port:8774); this instances doesn't seem to be able to reach security groups. This seems to be the result whether I have API ports open on a security group.