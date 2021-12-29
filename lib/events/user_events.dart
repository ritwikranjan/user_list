abstract class UserEvent {}

// Event to fetch user list from local database
class FetchUsersEvent extends UserEvent {}

// Event to fetch user list from remote database and save to local database
class RefreshUsersEvent extends UserEvent {}
