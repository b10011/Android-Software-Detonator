Android Software Detonator
==========================

Legal stuff
-----------
This software is distributed as is without any warranty. It shall not be used for reverse-engineering any application the user do not have permission to reverse-engineer. I take no responsibility of what will you use this software for. By using code of this project you you agree these Terms of Service.


Technical stuff
---------------

NOTICE! There is not official Windows port although we try to place all methods using third party API or system calls to tools.rb and adb.rb so porting this won't be as painful. There might be official Windows version in near future after others or I dare to stop using Linux ;)

Program made in Ruby which is helpful at maintaining clear folder structure and speeds up reverse-engineering itself.

This program is licensed under MIT license but in real world I don't give a shit as long as you don't claim my work as yours.

Hence I don't know that much of licensing I won't provide tools this program uses within my program in near future until I find out if authors of those tools will allow it. That's why for unknown time you need to manually place third party software to tools/ -folder. Further help in Installation section.



What ASD provides to you?
- Maintain clear folder structure for your reverse-engineering projects
- Faster way to access most useful .apk reverse-engineering tools without that much wasting your time typing long paths to files.
- Speeds up the reverse-engineering process by offering shortcuts

Folder structure ASD uses

- Android-Software-Detonator
	- [Ruby executables by b10011]
	- tools
		- [apktool.jar (https://code.google.com/p/android-apktool/)]
		- [dex2jar (https://code.google.com/p/dex2jar/)]
		- [jd-core-java (https://github.com/nviennot/jd-core-java)]
	- projects
		- mysoftware
			- apk
				- original.apk
				- cracked.apk
			- java
				- original
				- cracked
			- jar
				- original.jar
				- cracked.jar
			- reversed
				- original
				- cracked
			- unzip
				- original
				- cracked



Installation
------------

1. Clone this repository
2. Create folder tools/ in root folder
3. Copy newest version of apktool to tools/ -folder WITH NAME "apktool.jar"
4. Copy newest version of dex2jar to tools/ -folder WITH NAME "dex2jar/"
5. Copy newest version of jd-core-java to tools/ -folder WITH NAME "jd-core-java.jar"
6. Install Android Debugging Bridge and make sure you have drivers needed for your phone (so command "adb devices" return something more than just empty list)
7. Use the software
8. Contribute to the project by adding new features and reporting bugs

Not working?
------------

Q: I did every single step correctly as listed above and yet still it is not working. What to do?  
A: Submit a bug report  

Q: I thought that this would make reverse-engineering child's play. I got sources what to do now?  
A: No, this project is not about making reverse-engineering easy. This is about automating all the crap that you would need to do manually. You still need to be able to use terminal and you need to be able to read Java and Smali.  
