# mailcube

### Build an image

To build a Docker image, run below command:

```shell
docker build -t mailcube .
```

### Start container

Once build, you can run your container using below command:

```shell
docker run -ti -p 25:25 -p 143:143 mailcube
```

### Send a test email

To send a test email, install `swaks` and use below command:

```shell
swaks --from sender@example.com --to recipient@example.com --server localhost:25 --header "Subject: Test email" --body "This is the test email's body."
```
