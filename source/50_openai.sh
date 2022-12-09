#!/usr/bin/env bash

openai_request() {
	local model=$1
	local prompt=$2
	local body='{"model": "'$model'","prompt": "'$prompt'","temperature": 0,"max_tokens": 100,"top_p": 1,"frequency_penalty": 0.0,"presence_penalty": 0.0,"stop": ["\n"]}'

	curl -s https://api.openai.com/v1/completions \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $OPENAI_API_KEY" \
		-d "$body"
}

tellme() {
	if [[ "$#" -lt 1 ]]; then
		tellme_usage
		return 1
	fi

	local model='text-davinci-003'
	local prompt='I am a highly intelligent question answering bot. If you ask me a question that is rooted in truth, I will give you the answer. If you ask me a question that is nonsense, trickery, or has no clear answer, I will respond with \"Unknown\".\n\nQuestion: What is human life expectancy in the United States?\nAnswer:Human life expectancy in the United States is 78 years.\n\nQuestion: Who was president of the United States in 1955?\nAnswer:Dwight D. Eisenhower was president of the United States in 1955.\n\nQuestion: Which party did he belong to?\nAnswer:He belonged to the Republican Party.\n\nQuestion: What is the square root of banana?\nAnswer:Unknown\n\nQuestion: How does a telescope work?\nAnswer:Telescopes use lenses or mirrors to focus light and make objects appear closer.\n\nQuestion: Where were the 1992 Olympics held?\nAnswer:The 1992 Olympics were held in Barcelona, Spain.\n\nQuestion: How many squigs are in a bonk?\nAnswer:Unknown\n\n'
	local question="'$*'"
	local prompt="${intro}Question: ${question}?"'\nAnswer:'

	openai_request $model "$prompt" | jq -r '.choices[] .text'
}

tellme_usage() {
	if [[ ! -z "$1" ]]; then
		echo -e "$1\n"
	fi
	echo "Usage: tellme <question>"
}
