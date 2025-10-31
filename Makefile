lint:
	tflint --recursive

fmt:
	terraform fmt -check -recursive

fix:
	terraform fmt -recursive
