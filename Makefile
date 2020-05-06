IS_CI_BUILD ?=

.INTERMEDIATE: init
init:
ifdef IS_CI_BUILD
	# Build required images to run tests on python 2 and 3...
	@docker-compose build --pull
endif
	# Bring up the containers required to run the tests...
	@docker-compose up -d

.PHONY: test
test: init
	# Run maven clean and test
	@docker-compose exec -T amazon-ecs-plugin-temp mvn clean test

.PHONY: build
build: init
	# Run Maven Clean Install (Runs tests and builds artifact)
	@docker-compose exec -T amazon-ecs-plugin-temp mvn clean install
	

.PHONY: test
clean:
	# Remove containers and leftover files...
	@docker-compose exec -T amazon-ecs-plugin-temp mvn clean
	@docker-compose down --rmi all