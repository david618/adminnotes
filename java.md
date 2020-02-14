
## Java on Mac

```
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8
```
  
Then in my .bash_profile.
 
```
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0_242)
export PATH=$JAVA_HOME:$PATH
```
 
The java_home command spits back what versions of Java Mac knows about. 

```
/usr/libexec/java_home -V
Matching Java Virtual Machines (3):
    12.0.1, x86_64:    "OpenJDK 12.0.1"    /Library/Java/JavaVirtualMachines/openjdk-12.0.1.jdk/Contents/Home
    1.8.0_242, x86_64:    "AdoptOpenJDK 8"    /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
    1.8.0_162, x86_64:    "Java SE 8"    /Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home
/Library/Java/JavaVirtualMachines/openjdk-12.0.1.jdk/Contents/Home
```
