RC_FILE=${BASE_DIR:-..}/.profile/bashrc
exec bash -c 'echo "subshell" && bash --rcfile ../.profile/bashrc'
