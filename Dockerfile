FROM ruby:3

LABEL "com.github.actions.name"="Danger"
LABEL "com.github.actions.description"="Runs danger in a docker container such as GitHub Actions"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"
LABEL "repository"="https://github.com/danger/danger"
LABEL "homepage"="https://github.com/danger/danger"
LABEL "maintainer"="Rishabh Tayal <rtayal11@gmail.com>"
LABEL "maintainer"="Orta Therox"

RUN apt-get update -qq && apt-get install -y build-essential p7zip unzip

# See https://github.com/actions/runner/issues/2033
RUN git config --system --add safe.directory /github/workspace

RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp

RUN gem build 
RUN gem install danger*.gem danger-gitlab
ENV GITLAB_API_HTTPARTY_OPTIONS="{verify: false}"
RUN danger --version
cmd ["danger"]
