# Portable Apps
A collection of Windows applications made fully portable, while keeping the binaries and data contained in a single folder and leaving behind no trace on the system it's been run on

### What is this, and how does it work?
This repository contains applications that are normally not amenable to being portable, made portable through the use of symbolic links, aka symlinks (simply put, it's like a shortcut, except that it behaves like the folder or file has been cloned and not just linked), VBScript and Command Prompt batch files as invisible launchers.

The advantage of this approach, is that there is practically zero overhead in running a portable app -- unlike the packages created by softwares like VMware ThinApp that put all files in a single file, and then creating additional folders and files for user data, making it somewhat of an annoyance when it comes to moving the application between systems -- because it uses no extra tools other than the scripting languages baked into Windows. The best advantage, however, is the system integration that this approach allows for: the applications can be launched from the right-click context menu, in any folder, at any time.

![alt-text](https://user-images.githubusercontent.com/32809089/112467734-6dfaf300-8d8d-11eb-80ff-8614bdf902f3.png)

### What happens to my data when I'm running it?
Below is what the contents of a standard portable app folder look like. All your data stays in that data folder, and is symlinked to the directories where the program normally expects it to be. Once you exit the program, the launcher script (start.vbs) runs cleanup operations to remove the symlinks and any temporary files or caches

![alt-text](https://user-images.githubusercontent.com/32809089/112468659-8cadb980-8d8e-11eb-8402-46254a7e82d1.png)


