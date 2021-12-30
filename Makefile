RELEASE_VERSION := 1.0.5

GITHUB_TOKEN := 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
DOCKERHUB_TOKEN := 7c725cd5-c1a4-465e-b5e8-b7f13acb556d

GITHUB_USER := hazuki3417
GITHUB_REPOSITORY := ${GITHUB_USER}/verify-github-actions

DOCKERHUB_USER := hazuki3417
DOCKERHUB_REPOSITORY := ${DOCKERHUB_USER}/verify-github-actions

IMAGE_OWNER := ${GITHUB_USER}
IMAGE_NAME := verify-github-actions
IMAGE_VERSION := ${RELEASE_VERSION}

FULL_IMAGE_NAME_LATEST := ${IMAGE_OWNER}/${IMAGE_NAME}:latest
FULL_IMAGE_NAME_VERSION := ${IMAGE_OWNER}/${IMAGE_NAME}:${IMAGE_VERSION}



workflow-dh:
	make build && \
	make set-tag && \
	make login-dh && \
	make push-dh

build:
	docker-compose build ${IMAGE_NAME}

set-tag:
	make set-tag-latest && \
	make set-tag-version

set-tag-latest:
	docker tag ${IMAGE_NAME} ${FULL_IMAGE_NAME_LATEST}

set-tag-version:
	docker tag ${IMAGE_NAME} ${FULL_IMAGE_NAME_VERSION}

login-ghcr:
	@echo ${GITHUB_TOKEN} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

login-dh:
	@echo ${DOCKERHUB_TOKEN} | docker login -u ${DOCKERHUB_USER} --password-stdin

# 最も最新のものが先頭に表示されるので、latest imageは最後のpushする
push-dh:
	docker push ${FULL_IMAGE_NAME_VERSION} && \
	docker push ${FULL_IMAGE_NAME_LATEST}

# 最も最新のものが先頭に表示されるので、latest imageは最後のpushする
push-ghcr:
	docker push ${FULL_IMAGE_NAME_VERSION} && \
	docker push ${FULL_IMAGE_NAME_LATEST}

