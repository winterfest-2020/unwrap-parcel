# :key: IssueOps based certificate authority for GitHub orgs :key:

### Why

Many administrators would love to restrict cloning and pushing to GitHub repos to certain IPs and auto-expiring keys. GitHub provides that functionality [out of the box](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/about-ssh-certificate-authorities), but it is quite complicated to setup and maintain:

![image](https://user-images.githubusercontent.com/1872314/93902515-e8bc5600-fcf7-11ea-85a4-c52e687ea349.png)

If we had a way to automate all steps by just creating an issue - the ssh certificate authority feature would have a much higher chance to be used.

### Try it out

1. [Configure](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/about-ssh-certificate-authorities) your org to use a ssh certificate authority

![image](https://user-images.githubusercontent.com/1872314/93935781-6fd3f300-fd25-11ea-8e6e-c5f7b7ab56cd.png)

2. Create a copy of this repository template in that organization

![image](https://user-images.githubusercontent.com/1872314/93935555-166bc400-fd25-11ea-8e1b-0999a6f62530.png)

3. [Set](https://docs.github.com/en/actions/reference/encrypted-secrets) your CA private key as `SSH_CERTIFICATE`secret

4. Create an issue with the `Sign ssh key` [issue template](.github/ISSUE_TEMPLATE/sign-ssh-key.md) which will trigger the [issue ops sign ssh key workflow](.github/workflows/issue-ops-sign-ssh-key.yaml)

![image](https://user-images.githubusercontent.com/1872314/93902210-9844f880-fcf7-11ea-9723-3e0d57622b1d.png)

5. Profit

### :lock: Bonus encryption / decryption IssueOps workflow :lock:

In a first iteration, we experimented with generating ssh keys from scratch and send them encrypted to the user. We abandoned this idea for signing already uploaded ssh keys. A leftover from our experiments is an [IssueOps encryption workflow](.github/workflows/issue-ops-encrypt-content.yaml) that can be triggered by using the `Encrypt and share content` [issue template](.github/ISSUE_TEMPLATE/encrypt-content.md) and encrypts any content in the issue description with the public ssh keys of the specified recipient (with a comment how to decrypt):

![image](https://user-images.githubusercontent.com/1872314/93903714-50bf6c00-fcf9-11ea-85e1-a793144aa384.png)

For encryption/decryption, the portable, lightweight encryption tool [age](https://github.com/FiloSottile/age) is used, which could either be used directly from this repo template (Windows, Linux, Mac) or [build/installed from scratch](https://github.com/FiloSottile/age#installation).

### :gift: Second bonus - Encrypted Winterfest parcels :gift:

For GitHub Winterfest - we designed a [third IssueOps workflow](.github/workflows/issue-ops-send-encrypted-winterfest-parcel.yaml) that is very similar to the encryption based one just that it always assumes the issue opener to be the receiver and a configurable secret `WINTERFEST_SECRET` is used as encrypted payload. It also comes with a [festive issue template](.github/ISSUE_TEMPLATE/send-encrypted-winterfest-parcel.md).
Have fun trying it out.
