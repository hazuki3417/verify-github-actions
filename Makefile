# cli option経由で指定すること
################################################################################
RELEASE_VERSION := 1.0.5

GITHUB_TOKEN := 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
DOCKERHUB_TOKEN := 7c725cd5-c1a4-465e-b5e8-b7f13acb556d

GITHUB_USER := hazuki3417
DOCKERHUB_USER := hazuki3417
################################################################################

GITHUB_REPOSITORY := ${GITHUB_USER}/verify-github-actions
DOCKERHUB_REPOSITORY := ${DOCKERHUB_USER}/verify-github-actions

IMAGE_OWNER := ${GITHUB_USER}
IMAGE_NAME := verify-github-actions
IMAGE_VERSION := ${RELEASE_VERSION}

IMAGE_NAME_LATEST_FOR_DH := ${IMAGE_OWNER}/${IMAGE_NAME}:latest
IMAGE_NAME_VERSION_FOR_DH := ${IMAGE_OWNER}/${IMAGE_NAME}:${IMAGE_VERSION}

IMAGE_NAME_LATEST_FOR_GHCR := ghcr.io/${GITHUB_USER}/${IMAGE_OWNER}/${IMAGE_NAME}:latest
IMAGE_NAME_VERSION_FOR_GHCR := ghcr.io/${GITHUB_USER}/${IMAGE_OWNER}/${IMAGE_NAME}:${IMAGE_VERSION}


build:
	docker-compose build ${IMAGE_NAME}


set-tag-dh:
	docker tag ${IMAGE_NAME} ${IMAGE_NAME_LATEST_FOR_DH} && \
	docker tag ${IMAGE_NAME} ${IMAGE_NAME_VERSION_FOR_DH}

login-dh:
	@echo ${DOCKERHUB_TOKEN} | docker login -u ${DOCKERHUB_USER} --password-stdin

# 最も最新のものが先頭に表示されるので、latest imageは最後のpushする
push-dh:
	docker push ${IMAGE_NAME_VERSION_FOR_DH} && \
	docker push ${IMAGE_NAME_LATEST_FOR_DH}



set-tag-ghcr:
	docker tag ${IMAGE_NAME} ${IMAGE_NAME_LATEST_FOR_GHCR} && \
	docker tag ${IMAGE_NAME} ${IMAGE_NAME_VERSION_FOR_GHCR}

login-ghcr:
	echo ${GITHUB_TOKEN} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

# 最も最新のものが先頭に表示されるので、latest imageは最後のpushする
push-ghcr:
	docker push ${IMAGE_NAME_VERSION_FOR_GHCR} && \
	docker push ${IMAGE_NAME_LATEST_FOR_GHCR}




