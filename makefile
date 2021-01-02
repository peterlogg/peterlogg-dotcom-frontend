include .env
export $(shell sed 's/=.*//' .env)

.PHONY: build start_dev start clean

app_name := peterlogg-dotcom-frontend

build:
	elm-app build
	touch $@

start_dev: src/Main.elm
	elm-live $<

start:
	elm-app start

image:
	docker build -t peterlogg-dotcom-frontend --build-arg ELM_APP_BACKEND_URL=${ELM_APP_BACKEND_URL} .

clean:
	rm -rf build
	rm -rf public


deploy_ci_trigger:
	gcloud beta builds triggers create github \
    --name="${app_name}-trigger" \
	--description="CI for deployment of frontend application" \
    --repo-owner="peterlogg" \
    --repo-name="${app_name}" \
    --branch-pattern="^master$$" \
	--substitutions=_ELM_APP_BACKEND_URL="${ELM_APP_BACKEND_URL}" \
    --build-config="cloudbuild.yaml"

clean_trigger:
	gcloud beta builds triggers delete "${app_name}-trigger"
