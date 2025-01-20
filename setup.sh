curl -LsSf https://astral.sh/uv/install.sh | sh
uv pip install markitdown
uv pip install yt-dlp
uv pip install files-to-prompt
uv tool install copychat
uv pip install git+https://github.com/OpenInterpreter/open-interpreter.git@development
interpreter --help
llm install llm-cmd