TOOL = swift run -c release --package-path Tools
PACKAGE = swift package --package-path Tools
SWIFT_FILE_PATHS = Package.swift Sources Tests Gomoku
TEST_PLATFORM_IOS = iOS Simulator,name=iPhone 14 Pro Max
TEST_PLATFORM_MACOS = macOS
TEST_PLATFORM_TVOS = tvOS Simulator,name=Apple TV 4K (at 1080p) (2nd generation)
LIBRARY_SCHEME = GomokuBot
PRODUCT = Gomoku
EXAMPLE_SCHEME = Gomoku

.PHONY: format
format:
	$(TOOL) swift-format format -i -p -r $(SWIFT_FILE_PATHS)

.PHONY: lint
lint:
	$(TOOL) swift-format lint -s -p -r $(SWIFT_FILE_PATHS)

.PHONY: docs
docs:
	$(PACKAGE) \
	  --allow-writing-to-directory docs \
	  generate-documentation \
	  --product $(PRODUCT) \
	  --disable-indexing \
	  --transform-for-static-hosting \
	  --hosting-base-path $(PRODUCT) \
	  --output-path docs

.PHONY: docs-preview
docs-preview:
	$(PACKAGE) \
	  --disable-sandbox \
	  preview-documentation \
	  --product $(PRODUCT)

.PHONY: test
test: test-library build-examples

.PHONY: resolve-dependencies
resolve-dependencies:
	xcodebuild -resolvePackageDependencies

.PHONY: test-library
test-library:
	for platform in "$(TEST_PLATFORM_IOS)" "$(TEST_PLATFORM_MACOS)" "$(TEST_PLATFORM_TVOS)"; do \
	  xcodebuild test -scheme $(LIBRARY_SCHEME) -destination platform="$$platform"; \
	done

.PHONY: test-library-iphone
test-library-iphone:
	for platform in "$(TEST_PLATFORM_IOS)"; do \
      xcodebuild test -scheme $(LIBRARY_SCHEME) -destination platform="$$platform"; \
	done

.PHONY: test-example
test-example:
	cd $(EXAMPLE_SCHEME) && xcodebuild test -scheme $(EXAMPLE_SCHEME) -destination platform="$(TEST_PLATFORM_IOS)"

.PHONY: build-examples
build-examples:
	cd $(EXAMPLE_SCHEME) && xcodebuild build -scheme $(EXAMPLE_SCHEME) -destination platform="$(TEST_PLATFORM_IOS)"
