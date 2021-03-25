# Portable Apps
A collection of Windows applications made fully portable and movable while contained in a single folder, <i>leaving behind no trace on the system it's been run on.</i>

![alt-text](https://user-images.githubusercontent.com/32809089/112470879-35f5af00-8d91-11eb-9fc7-54ff11e3c138.png)

### What is this, and how does it work?
This repository contains applications that are normally not amenable to being portable, made portable through the use of <b>symbolic links, aka symlinks</b> (simply put, it's like a shortcut, except that it behaves like the folder or file has been cloned and not just linked), and <b>VBScript</b> and <b>Command Prompt batch files</b> as invisible launchers that do all the component (de)registration, launching and cleanup processes.

The advantage of this approach, is that there is practically <i>zero overhead</i> in running a portable app – unlike the packages created by softwares like VMware ThinApp that put all files in a single file, and then creating additional folders and files for user data, making it somewhat of an annoyance when it comes to moving the application between systems – because it uses no extra tools other than the scripting languages baked into Windows. The best advantage, however, is the system integration that this approach allows for: the applications can be launched from the right-click context menu, in any folder, at any time.

![alt-text](https://user-images.githubusercontent.com/32809089/112467734-6dfaf300-8d8d-11eb-80ff-8614bdf902f3.png)

### What happens to my data when I'm running it?
Below is what the contents of a standard portable app folder look like. All your data stays in that data folder, and is symlinked to the directories where the program normally expects it to be. Once you exit the program, the launcher script (start.vbs) runs cleanup operations to remove the symlinks and any temporary files or caches.

![alt-text](https://user-images.githubusercontent.com/32809089/112468659-8cadb980-8d8e-11eb-8402-46254a7e82d1.png)

### Hey, why are some of the apps listed above not in the repository?
Licensing issues. They are proprietary software that I've purchased and made portable for my own use (especially because I tend to change OSes frequently, so it's convenient for me to have portable apps instead of having to reinstall them all over) and it's likely not legal to redistribute. Also note that some of these applications, like MATLAB, create license files that use an ID generated from your machine configuration, so you'd have to re-license every time you take the app to a new machine, which I believe is actually forbidden in the EULA (but it's still possible, provided you have your license file).

I am only redistributing freeware and open-source applications that haven't been modified otherwise and carry the original software licenses of their creators, until otherwise specified.

### Nice! How do I get those apps in the right-click menu?
First, put all the apps you want in a folder, say D:\Portables, then run the add-to-context-menu.cmd batch file you can find in the root of this repository. From there, the process is self-explanatory. In apps that have multiple .vbs launchers (like Chromium's start_70.0.3538.110.vbs and start_83.0.4103.116.vbs) you get to choose your default launcher by index values.
