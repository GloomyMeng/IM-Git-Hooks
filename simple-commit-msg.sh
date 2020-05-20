#!/bin/sh

crashLogMsg() {
	echo "Fix Commit Message 不规范，请检查!具体格式需要满足："
	echo "=> fix [(normal|crashed))]: jira (BugID)"
	
	echo "其中：normal:     普通 bug"
	echo "     crashed:    会引起 crash 的 bug"
}

COMMIT_MSG=`cat $1 | egrep "^(feat|fix|docs|refactor|build|chore|test)\[\w+\]?:\s(\S|\w)+"`
RESULT=`cat $1 | egrep "^fix\[(crashed|normal)]?:\sjira\s[0-9]+"`
if [ "$RESULT" = "" ]; then
	crashLogMsg
	exit 1
fi
