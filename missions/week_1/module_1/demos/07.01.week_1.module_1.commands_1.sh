echo '* Type # hello world to create a comment.'
echo '* Press enter, and you will see that the comment is not executed.'
echo '* Try it again without the # symbol to see the difference.'
exec bash --rcfile $RCFILE
