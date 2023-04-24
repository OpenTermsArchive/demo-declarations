# Open Terms Archive - template for declarations

## How to use this template

This is a template for the `declarations` repository of [Open Terms Archive](https://opentermsarchive.org)

**NOTE**: When creating from this template, please keep the naming structure of `${instanceName}-declarations` in order to keep consistency across repos and organisations.

In order to use it, follow this simple steps:
- Navigate to https://github.com/OpenTermsArchive/template-declarations
- Click on `Use this template`
- Enter the name of the target repository `${instanceName}-declarations` and the target organization
- Edit this file by clicking on the ![Edit Button](https://raw.githubusercontent.com/primer/octicons/main/icons/pencil-24.svg "Look, on the right of the title README.md") icon at the top right of this file *(This icon is visible if you have the right to modify this repo)*
- Remove this paragraph and replace the `${instanceName}`
- Add any documentation you find necesary

You can also check the complete doc: [How to use a template on Github](https://docs.github.com/en/github-ae@latest/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)

Then you need to
- Follow the instructions to [Continuous Deployment](#continuous-deployment)
- Clone the repository you just created and named `${instanceName}-declarations`
- Launch `./init.sh` and the script will guide you for the configuration
- Commit the files to git `git add . && git commit -m "Initiate instance"`

This will replace the corresponding variables in the files and remove the now useless files.

### Continuous Integration

#### Deployment

For continuous deployment on your server, you need to define the following variables as [GitHub secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository):

- `SERVER_FINGERPRINT`: obtained with `ssh-keyscan -H $serverAddress`.
- `SERVER_SSH_KEY`: a private SSH key allowed to connect to your server.
> You can for example generate one on your server with `ssh-keygen -q -N "" -f ~/.ssh/ota-deploy && cat ~/.ssh/ota-deploy.pub >> authorized_keys`, and store the contents of `~/.ssh/ota-deploy` as the `SERVER_SSH_KEY` secret.

#### Integration

For GitHub worflows to run from a fork of your collection, see the [reference documentation](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks).

- - - -

## License

The code in this repository is distributed under the GNU Affero General Public Licence (AGPL) v3.0.
