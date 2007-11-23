
Quarks

A Quark is a package of SC classes, helpfiles, C++ source for UGens and/or other SC code.
The packages are stored in a Subversion (SVN) repository and downloaded/updated automatically.

You will need the subversion client software installed ( http://subversion.tigris.org ). To check whether you already have it, type "svn help" in a terminal window.


Recommended typical usage

First make sure your Quarks directory is up-to-date:

Quarks.checkoutDirectory // Do this if it's your first time
Quarks.updateDirectory  // Otherwise do this

Then either launch the GUI to manage which Quarks you want to install...

Quarks.gui

...or use the "install" command directly:

Quarks.install("testquark"); // This will DOWNLOAD and install as needed, inc dependencies

After a quark is installed you must recompile the language so that it's aware of the new extensions. Then you can use it:

TestQuark.sayHello

You can of course uninstall quarks if you decide you don't need them:

Quarks.uninstall("testquark");


Annoyances

Quarks executes various SVN shell commands to download files. If you get this error appearing:

Error validating server certificate for 'https://supercollider.svn.sourceforge.net:443':
- The certificate is not issued by a trusted authority. Use the
 fingerprint to validate the certificate manually!
Certificate information:
- Hostname: *.sourceforge.net
- Valid: from Jan 17 18:17:01 2007 GMT until Mar 18 18:17:01 2008 GMT
- Issuer: Equifax Secure Certificate Authority, Equifax, US
- Fingerprint: a1:3a:51:83:60:5e:81:07:be:6c:06:d1:db:34:9b:d8:b9:40:b5:d0
(R)eject, accept (t)emporarily or accept (p)ermanently? svn: PROPFIND request failed on '/svnroot/quarks'
svn: PROPFIND of '/svnroot/quarks': Server certificate verification failed: issuer is not trusted (https://supercollider.svn.sourceforge.net)
RESULT = 256

you want to accept (p)ermanently, but since you didn't do it through a shell you can't hit "p". 

Solution: Copy and paste the shell command that was posted
eg.
export LANG='' ; /usr/local/bin/svn update /Users/cruxxial/Library/Application\ Support/SuperCollider/quarks/DIRECTORY/ 2>&1

into your shell and run it there. Hit the "p". After that it won't bother you again.



Check out all available Quarks

Quarks.checkoutAll

This downloads them into {Application Support Directory}/quarks but does not yet install them into your class library.

It can be particularly helpful because you won't in future need to have an internet connection to install the quarks: they are already downloaded even if not installed.

// post those checked out
Quarks.checkedOut

// post those checked out with a description
Quarks.listCheckedOut

Checking out a single Quark

If you have never checked out any part of the Quarks repository, you must first check out the directory.

Quarks.checkoutDirectory

Otherwise, you may simply update the existing directory to check for new or changed Quarks.

// this updates {Application Support}/quarks/DIRECTORY
Quarks.updateDirectory

That folder contains simple quark files with information like name, path, summary, author etc. for each quark in the repos.
Those files are also human-readable.

// list all quarks in the repository
Quarks.repos.quarks

// checkout the specific one that you want
Quarks.checkout( "testquark" )



Install

This symlinks the quark's sourcecode folder into your Extensions directory. The source code itself stays in the quarks folder, but the symlink is in your Extensions directory, so when you recompile the class library, the quark will be included.

Quarks.install( "testquark" )

Recompile your SC library...

// test it
TestQuark.sayHello


// list those installed
Quarks.installed

Note: Quarks may specify other quarks that they are dependent on. Quarks.install will also attempt to install those other quarks that the desired quark depends upon, if not already installed. You can prevent this if neccessary by passing false as the second argument to Quarks.install.

Quarks.install( "somequark", incdeps: false )

Similarly the install command will attempt to download quarks if you don't already have them locally. You can prevent this using the allowCheckout argument:

Quarks.install( "somequark", allowCheckout: false )


Uninstall

Quarks.uninstall( "testquark" )



// list those installed
Quarks.installed

// list those in the repository that you could checkout
Quarks.repos.quarks

// list those that you have checked out and could now install
Quarks.local.quarks


Other

The Quarks class interface mirrors the familar svn commands while substituting in the correct paths.

Quarks.update( "testquark" )
Quarks.update // updates all

Quarks.status( "testquark" )
Quarks.status // status of all

You may also use any standard SVN tools which is probably easier especially for add and commit.

The principal repository is located at:

https://quarks.svn.sourceforge.net/svnroot/quarks


Creating a Quark for others to use

You will need a (free) SourceForge account to publish a quark to the subversion repository. (You also need the account to be added to the "quarks" project - contact one of the admins listed at http://sourceforge.net/projects/quarks to do that.) Once you're authorised, here's what to do:

Create your folder in {Application Support}/quarks/
(we'll assume it's called quarkname)

In a shell go to {Application Support}/quarks/ and execute :

svn add quarkname

Place a quark file called quarkname.quark into {Application Support}/quarks/DIRECTORY
(see [Quark] for the format)

Then to publish:

svn add DIRECTORY/quarkname.quark

svn commit -m "adding quarkname"






Local Repository Example

Besides the public repos at sourceforge you can use any other subversion host including a repository running on your local machine. This is useful in that you get version control and an easy way to manage package installation.

For obvious reasons you need to have a running subversion system somewhere in order to use this feature.
Nevertheless it is possible to use alreadily existing subversion quarks directories (as the SonEnvir one).

1.	Create a directory in svn-repos (e.g. quarks-<yourname/id/institution>).
	!This name has to be unique to all Quark repositories you will ever check out!

	Create a dir within it called "DIRECTORY" containing quark files.

2.	Fill repos with your work
	
3.	Now use Quarks to make it accessible in SC (shown at hand of the existing and
	publicly available SonEnvir quarks):

	~qSonEnvir = Quarks(
		reposPath: "https://svn.sonenvir.at/repos/SonEnvir/trunk/src/quarks-sonenvir",
		localPath: Platform.userAppSupportDir ++ "/quarks-sonenvir"
	);
	
	~qSonEnvir.checkoutAll;
	// or, if alreadily checked out at the appropriate place:
	~qSonEnvir.update;

4.	now install your quarks:

	~qSonEnvir.listCheckedOut;

	~qSonEnvir.install("sonenvir-testquark");
	~qSonEnvir.isInstalled("sonenvir-testquark");

	~qSonEnvir.listInstalled

5.	recompile
6.	test
	
	SonEnvirTestQuark.sayHello
	
	~qSonEnvir = Quarks(
		reposPath: "https://svn.sonenvir.at/repos/SonEnvir/trunk/src/quarks-sonenvir",
		localPath: Platform.userAppSupportDir ++ "/quarks-sonenvir"
	);

[...]

N.	remove what you're don't need
	~qSonEnvir.uninstall("sonenvir-testquark")
	
	// recompile
	SonEnvirTestQuark.sayHello
	// -> error
	
	
M.	update

	~qSonEnvir.updateDirectory
	~qSonEnvir.update
	
	
	


