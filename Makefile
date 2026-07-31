.PHONY: new-skill validate

new-skill:
	@./scripts/new-skill.sh $(PLUGIN) $(NAME)

validate:
	@./scripts/validate.sh
