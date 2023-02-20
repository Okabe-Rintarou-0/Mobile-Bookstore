const String scheme = "http";
// const String host = "47.103.71.157";
const String host = "10.0.2.2";
const String port = "8080";
const String apiPrefix = "$scheme://$host:$port";

const bookDetailsUrl = "$apiPrefix/books/details";
const bookSnapshotUrl = "$apiPrefix/books/snapshot";
const bookRangedSnapshotsUrl = "$apiPrefix/books/snapshots";
const checkSessionUrl = "$apiPrefix/checkSession";
const loginUrl = "$apiPrefix/login";
