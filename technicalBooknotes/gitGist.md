#Git 基本操作
[返回首页](../index.html)

[返回技术书籍笔记](./technicalBooknotesIndex.html)

git本地新建目录，push到远程仓库的方法：

- mkdir gitRepo
- cd gitRepo
- git init  #初始化本地仓库
- git add xxx  #添加要push到远程仓库的文件或文件夹
- git commit -m 'first commit'  #提交zhiqadd的文件
- git remote add origin https://github.com/yourgithubID/gitRepo.git  #建立远程仓库
- git push -u origin master #将本地仓库push到远程仓库

p.s. : 需要先在github手动创建repo

###Git详细操作
Git是一个仓库，在本仓库及子目录下的文件才可以被检索到。

git add命令可以将文件加入到仓库中，例子：git add readme.txt

git add —all

git commit 讲文件提交到库，例子：git commit -m “wrote a readme file."
-m 后面表示提交的说明。

git status 显示仓库当前的状态

git diff readme.txt 查看修改内容

git log查看历史记录

git reset —hard XXX 把当前版本回退到XXX

git reflog 来查看每一次命令和相应的SHA1值，用来调整版本

我们把文件往Git版本库里添加的时候，是分两步执行的：

- 第一步是用git add把文件添加进去，实际上就是把文件修改添加到暂存区；
- 第二步是用git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。

每次修改，如果不add到暂存区，那就不会加入到commit中

git add将修改放入暂存区，还没有新生成一个版本，commit之后生成一个版本，再push之后才会在向公共版本上提交更新

`Changes not staged for commit:` 表示文件在工作区，可以add了

`Changes to be committed:` 表示文件在暂存区，可以commit了

命令git checkout -- readme.txt意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：

- 一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
- 一种是readme.txt已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。

总之，就是让这个文件回到最近一次git commit或git add时的状态。

用命令git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区

`$ git reset HEAD readme.txt`

`Unstaged changes after reset:
M       readme.txt`

上面从暂存区回到了工作区。

综上，对于已经添加在暂存区的文件，撤回过程为：

- git checkout — readme.txt 退回到刚加入暂存区时的状态

- git reset HEAD file，把暂存区清空

- git checkout — readme.txt 丢弃工作区的修改

删错了，因为版本库里还有呢，所以可以很轻松地把误删的文件恢复到最新版本：

`$ git checkout -- test.txt`

git checkout其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。

要关联一个远程库，使用命令git remote add origin git@server-name:path/repo-name.git；

关联后，使用命令`git push -u origin master`第一次推送master分支的所有内容；
此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改；

### 分支管理

我们创建dev分支，然后切换到dev分支：

`$ git checkout -b dev`

`Switched to a new branch 'dev'`


git checkout命令加上-b参数表示创建并切换，相当于以下两条命令：

`$ git branch dev`

`$ git checkout dev`

`Switched to branch 'dev'`



然后，用git branch命令查看当前分支：


`$ git branch`

`* dev`

`master`

然后，我们就可以在dev分支上正常提交，比如对readme.txt做个修改，加上一行：


Creating a new branch is quick.


然后提交：


`$ git add readme.txt `

`$ git commit -m "branch test"`

`[dev fec145a] branch test`

`1 file changed, 1 insertion(+)`


现在，dev分支的工作完成，我们就可以切换回master分支：


`$ git checkout master`

`Switched to branch 'master'`

切换回master分支后，再查看一个readme.txt文件，刚才添加的内容不见了！因为那个提交是在dev分支上，而master分支此刻的提交点并没有变

`git merge dev`将dev分支合并到Master上

`git branch -d dev`删除dev分支

查看分支：git branch

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>

合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。

首先，master分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；


那在哪干活呢？干活都在dev分支上，也就是说，dev分支是不稳定的，到某个时候，比如1.0版本发布时，再把dev分支合并到master上，在master分支发布1.0版本；


你和你的小伙伴们每个人都在dev分支上干活，每个人都有自己的分支，时不时地往dev分支上合并就可以了。


所以，团队合作的分支看起来就像这样：


- git stash 可以把工作现场储藏起来
- git stash list可以看到所有工作现场
- git stash apply可以恢复现场，但stash的内容不删除，用git stash drop来删除
- git stash pop可以恢复同时删除
- git stash apply stash@{0}恢复指定位置的工作现场

### 合作管理
开发一个新feature，最好新建一个分支；
如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除。

将某个分支推送到远程分支上 git push origin XXX

删除远程上的一个分支
git push origin --delete <branchName>

设置dev和origin/dev的链接：


`$ git branch --set-upstream dev origin/dev`

`Branch dev set up to track remote branch dev from origin.`


再pull：


`$ git pull`

`Auto-merging hello.py`

`CONFLICT (content): Merge conflict in hello.py`

`Automatic merge failed; fix conflicts and then commit the result.`

这回git pull成功，但是合并有冲突，需要手动解决，解决的方法和分支管理中的解决冲突完全一样。解决后，提交，再push：


`$ git commit -m "merge & fix hello.py"`

`[dev adca45d] merge & fix hello.py`

`$ git push origin dev`

`Counting objects: 10, done.`

`Delta compression using up to 4 threads.`

`Compressing objects: 100% (5/5), done.`

`Writing objects: 100% (6/6), 747 bytes, done.`

`Total 6 (delta 0), reused 0 (delta 0)`

`To git@github.com:michaelliao/learngit.git`

 `  291bea8..adca45d  dev -> dev`

### Tag功能
命令git tag <name>用于新建一个标签，默认为HEAD，也可以指定一个commit id；

- git tag -a <tagname> -m "blablabla..."可以指定标签信息；

- git tag -s <tagname> -m "blablabla..."可以用PGP签名标签；
- 命令git tag可以查看所有标签。

- 忽略某些文件时，需要编写.gitignore；

.gitignore文件本身要放到版本库里，并且可以对.gitignore做版本管理！