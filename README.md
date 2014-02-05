# [SimpleDB](http://aws.amazon.com/jp/simpledb/) access iOS sample code

Using custom model like "Rails" model.

## Setup

```
$ mv simple_db/Constants.h.orig simple_db/Constants.h
$ $EDITOR simple_db/Constants.h # change SimpleDB's access key and secret
$ cp -a path/to/AWSRuntime.framework simple_db/frameworks/
$ cp -a path/to/AWSSimpleDB.framework simple_db/frameworks/
```


## Available queries

See [Building Amazon SimpleDB Queries](Building Amazon SimpleDB Queries)


## LICENSE

Apache 2.0
