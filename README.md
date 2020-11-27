# Teixim Cures

Teixim Cures is a marketplace implemented as a Rails app based on [Sharetribe](https://www.sharetribe.com).

## Development

We implementd a specific docker environment in `docker-compose.dev.yml` based on Sharetribe's development setup instructions.

First install [direnv](https://direnv.net/). You can do so in Ubuntu by running:

```bash
sudo apt install direnv
```

and follow the rest of the [installation steps](https://direnv.net/#basic-installation). Close and reopen your terminal and navigate to the project again. Note that the first time `direnv` will ask you to execute `direnv allow` for security reasons. Do so and proceed to the next step.

Now, start the containers as usual:

```bash
docker-compose up
```

The first time you'll need to create and initialize the database from a separate terminal as follows:

```bash
docker-compose exec web bundle exec rake db:create db:structure:load db:seed
```

Now, follow the message `db:seed` outputs to log into the marketplace and you'll be good to go.

## This is not a fork

This repo is not a Github fork of https://github.com/sharetribe/sharetribe. It's a standalone repo that uses Sharetribe's as Git upstream. As a result, you won't see any references to it from Github's UI but we can sync our repo with upstream when new releases are published.
