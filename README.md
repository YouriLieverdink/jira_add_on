![Jira add-on logo](https://github.com/YouriLieverdink/jira_add_on/assets/89806453/bde3f778-491b-4ab4-8124-1b67ab277d2b)

Command-line interface to interact with Jira.

## 1. Quickstart

### 1.1 Prerequisites

In order to use this Jira add-on you must have the [Dart SDK](https://dart.dev/get-dart) installed on your machine.

### 1.2 Installing

1. Clone the repository
```sh
git clone https://github.com/YouriLieverdink/jira_add_on.git
```

2. Activate to be run from anywhere on your system
```sh
make activate
```

3. Create and edit the configuration file
```sh
cp .env.example ~/.config/jira_add_on/config
vim ~/.config_jira_add_on/config
```

*Note*: You can manage the Jira API tokens [here](https://id.atlassian.com/manage-profile/security/api-tokens).

4. Run
```sh
jira_add_on --help
```

## 2. Development

1. Clone the repository
```sh
git clone https://github.com/YouriLieverdink/jira_add_on.git
```

2. Get all depedencies
```sh
dart pub get
```

3. Create and edit the configuration file
```sh
cp .env.example .env
vim .env
```

4. Run
```sh
dart run ./bin/jira_add_on.dart --help
```
