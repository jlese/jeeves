.PHONY: new validate install-user install-workspace

new:
	@./scripts/new.sh $(KIND) $(NAME)

validate:
	@./scripts/validate.sh

install-user:
	@./scripts/install-user.sh

install-workspace:
	@./scripts/install-workspace.sh $(TARGET) $(MODE)
