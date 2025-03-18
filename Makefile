website:
	@npx @tailwindcss/cli -i ./client/styles.css -o ./src/output.css --watch &
	@npm run dev
