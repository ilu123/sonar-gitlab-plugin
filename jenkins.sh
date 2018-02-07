#!/bin/sh

chmod 777 gradlew

if [ "${ANALYSIS_MODE}" = "publish" ]; then
echo "Publish mode"
./gradlew sonar
else
COMMIT_SHA=$(git log --pretty='format:%H' origin/${gitlabTargetBranch}..origin/${gitlabSourceBranch} | tr '\n' ',')
./gradlew sonar --info -Dsonar.analysis.mode=${ANALYSIS_MODE} \
-Dsonar.gitlab.commit_sha=${COMMIT_SHA}  -Dsonar.gitlab.ref_name=${BRANCH_NAME}  -Dsonar.gitlab.project_id=${PROJECT_ID} -Dsonar.gitlab.disable_inline_comments=true -Duser.home=${JENKINS_HOME} \
# -Dsonar.cks.mr.iid=${MR_IID} -Dsonar.cks.mr.channel=slack-channel -Dsonar.cks.project.host=${PROJECT_HOST} -Dsonar.cks.project.id=${PROJECT_ID} -Dsonar.cks.git.token=${GIT_API_TOKEN} -Dsonar.cks.mr.note=false

fi

