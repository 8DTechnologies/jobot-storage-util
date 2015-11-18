# hubot-jobot-storage-util

Hubot script to deal with brain.data

See [`src/jobot-storage-util.coffee`](src/jobot-storage-util.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install jobot-storage-util --save`

Then add **jobot-storage-util** to your `external-scripts.json`:

```json
["jobot-storage-util"]
```

## Sample Interaction

```
user1>> hubot show storage
hubot>> {
    "users": {
        "1": {
            "id": 1,
            "name": "Shell",
            "room": "Shell",
            "type": "chat"
        }
    },
    "_private": {}
}
```

## License

 [MIT](/LICENSE.md) © [8D Technologies](http://8d.com)
