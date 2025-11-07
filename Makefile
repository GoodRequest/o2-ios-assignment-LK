.PHONY: help generate_resources generate_localizations

help:
	@echo "Available targets:"
	@echo "  generate_localizations - Generate L10n.swift from Localizable.strings"

generate_localizations:
	@echo "Generating L10n.swift from Localizable.strings..."
	@swift Scripts/generateL10n.swift

