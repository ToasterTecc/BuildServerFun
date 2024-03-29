# BuildServerFun
## **To the company that made me do this in a week FOR FREE without giving me ANY FEEDBACK and wanted the repo private, Γαμώ το σπίτι σου**
![alt text](https://imgur.com/3HOJXqz.png)
A local build server with a bash script for C projects. <br />
I had a week to do this, given time restrictions and my lack of full knowledge automating Git, I could not do the cron table script to do periodic builds and set up repo/commit integration. I also couldn't fully set up the build server so it can be accessed remotely via SSH.

But here are cool things it could do!
## Build Server 0.1 Features
- Drag and drop files, directories, literally anything to the bash script (and the script will check if it is a valid C project to be built)!
- The bash script can handle weird directories/files with spaces or apostraphies, duplicate entries, and if the C project is updated or not.
- The bash script has a memory file so you don't have to keep dragging repeatedly valid C project directories if you are going to reuse it.
- The bash script can also erase the memory file if you find it annoying that it auto builds the saved memory file directories.
- The bash script writes and registers all builds to the Build Server HTML.
- HTML site that has a build page to show the timestamp and location of recent builds and their build status.
- HTML site that can show you the location of the local repository / artifacts of the C projects (I used the local filesystem).
- HTML site has a refresh button that you can press to update in case you have built anything new.
##

## Installation

```sh
cd ~/project
bash ./Cbuild.sh
```
To check the local website just drag the "BuildServer.html" file to a tab of your browser and it will load. There is a refresh page for any new builds you did with the shell script.

## Future Features / Improvements TO:DO (that I didn't have time**)
- Really understand Git and how to automate it so you can include the C build script with it and tie in commits / Git repository to HTML website
- Finish integrating the Linode server I have running with this project so it doesn't become a local project but one you can SSH and do remotely
- Cron table  another script to periodically fetch new commits through Git and use the build script on them
- Maybe add SQL so the build page data can be organized and pruned after X entries or after 3 days
- Memory file check so you can add entries to the memory file for it to preload, then make it erase and reorganize itself for invalid build entries.
##

## Pictures of the bash script being tested
![alt text](https://imgur.com/CSrmNpT.png)
![alt text](https://imgur.com/ecAUQFC.png)
![alt text](https://imgur.com/z5M3Wzr.png)


## License

MIT

**Free Software, Hell Yeah!**
