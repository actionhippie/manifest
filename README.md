# manifest

[![Current Tag](https://img.shields.io/github/v/tag/actionhippie/manifest?sort=semver)](https://github.com/actionhippie/manifest) [![Docker Build](https://github.com/actionhippie/manifest/workflows/docker/badge.svg)](https://github.com/actionhippie/manifest/actions/workflows/docker.yml)

[GitHub Action](https://github.com/features/actions) to upload Docker image manifests.

## Usage

```yml
name: Example

on:
  - push
  - pull_request

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - uses: actionhippie/manifest@v1
        with:
          username: octocat
          password: p455w0rd
          platforms: linux/amd64,linux/arm64,linux/arm
          template: foo/bar-ARCH:v1
          target: foo/bar:v1
          ignore_missing: true
```

## Inputs

### `username`

Username for the used registry

### `password`

Password for the used registry

### `insecure`

Enable insecure access to the used registry, defaults to `false`

### `debug`

Enable debug output for manifest-tool, defaults to `false`

### `spec`

Path manifest file in YAML format

### `platforms`

List of the platforms that images should be pushed for

### `template`

Pattern the source images have, OS and ARCH will be replaced

### `target`

Name of the manifest list image that is going to be produced

### `ignore_missing`

Only warn on missing images defined in spec or list, defaults to `false`

## Outputs

None

## Security

If you find a security issue please contact thomas@webhippie.de first.

## Contributing

Generally we are following [conventional commits][commits] when we apply
changes. That way we are able to generate proper changelogs for every release.
Please use always pull requests to integrate new functionalities or to fix
issues.

For the release process we are following [semantic versioning][semver] which
clearly indicates if a new version just resolves bugs, includes new features or
even includes breaking changes.

After installing the tools via `mise install` as described above set up the
pre-commit hooks so they run automatically on every commit:

```console
prek install --hook-type pre-commit --hook-type commit-msg
```

> `prek` is managed by mise and will be available after `mise install`.

If you have changed something on the source you should simply commit following
the mentioned conventions:

```console
git checkout -b feat/new-feature
git add --all
git commit -m 'feat: added awesome new feature'
git push --set-upstream origin feat/new-feature
```

After pushing your changes into the Git repository you should create a pull
request on GitHub. If the pull request have been merged and everything built
fine it will also create automatically a new release at least once a week.

## Authors

*   [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2021 Thomas Boerger <thomas@webhippie.de>
```

[mise]: https://mise.jdx.dev/
[mise-install]: https://mise.jdx.dev/getting-started.html
[commits]: https://www.conventionalcommits.org/en/v1.0.0/
[semver]: https://semver.org/
