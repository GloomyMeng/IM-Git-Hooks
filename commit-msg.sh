#!/bin/sh

logMsg() {
	echo "Commit Message 不规范，请检查!具体格式需要满足："
	echo "=> (feat|fix|docs|refactor|build|chore|test)[模块]: 描述"
	
	echo "其中：feat:     增加新功能"
	echo "     fix:      修复bug"
	echo "     docs:     只改动了文档相关的内容"
	echo "     build:    构造工具的或者外部依赖的改动，例如pod,bunld 等"
	echo "     refactor: 代码重构时使用"
	echo "     test:     添加测试或者修改现有测试"
}

crashLogMsg() {
	echo "Fix Commit Message 不规范，请检查!具体格式需要满足："
	echo "=> fix [(normal|crashed))]: 描述"
	
	echo "其中：normal:     普通 bug"
	echo "     crashed:    会引起 crash 的 bug"
}

COMMIT_MSG=`cat $1 | egrep "^(feat|fix|docs|refactor|build|chore|test)\[\w+\]?:\s(\S|\w)+"`

if [ "$COMMIT_MSG" = "" ]; then
	logMsg
	exit 1
fi

if [ ${#COMMIT_MSG} -lt 15 ]; then
	echo "Commit Message 太短了，请再详细点!\n"
	exit 1
fi

if [[ "$COMMIT_MSG" =~ ^fix.* ]]; then
	RESULT=`cat $1 | egrep "^fix\[(crashed|normal)]?:\sjira\s[0-9]+"`

	if [ "$RESULT" = "" ]; then
		crashLogMsg
		exit 1
	fi
fi