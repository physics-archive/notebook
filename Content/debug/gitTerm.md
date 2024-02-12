git add .
git commit -m " "
git push 

git checkout branch
git push origin main:ba

--Deleted main branch to clean objects--
git branch --orphan name

--BFG Cleanup--
git clone --mirror git@github.com:physics-archive/notebook.git
bfg --strip-blobs-bigger-than 5M notebook.git
cd notebook.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push <-- Fails on one WiFi but not the other (broken pipe). Despite SSH/HTTP buffersize increase.
