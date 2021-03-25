# Portable Apps
A collection of Windows applications made fully portable, leaving behind no trace of execution on the system it's been run on, while keeping the binaries and data contained in a single folder.

### What is this, and how does it work?
This repository contains applications that are normally not amenable to being portable, made portable through the use of symbolic links (simply put, it's like a shortcut, except that it behaves like the folder or file has been cloned and not just linked), VBScript and Command Prompt batch files as invisible launchers.

The advantage of this approach, is that there is practically zero overhead in running a portable app -- unlike the packages created by softwares like VMware ThinApp that put all files in a single file, and then creating additional folders and files for user data, making it somewhat of an annoyance when it comes to moving the application between systems -- because it uses no extra tools other than the scripting languages baked into Windows. The best advantage, however, is the system integration that this approach allows for: the applications can be launched from the right-click context menu, in any folder, at any time.

![alt-text](https://user-images.githubusercontent.com/32809089/112467734-6dfaf300-8d8d-11eb-80ff-8614bdf902f3.png)
