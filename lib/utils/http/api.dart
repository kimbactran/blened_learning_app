class LApi {
  static const String baseUrl = 'http://192.168.11.38:3001';
  static _AuthApi authApi = _AuthApi();
  static _UserApi userApi = _UserApi();
  static _ClassroomApi classroomApi = _ClassroomApi();
  static _PostApi postApi = _PostApi();
  static _CommentApi commentApi = _CommentApi();
  static _TagApi tagApi = _TagApi();
}

class _TagApi {
  final String tagSyllabus = '/v1/tags/syllabus';
  final String tagFree = '/v1/tags/free';
  final String tagInClassroom = '/v1/tags/tag-by-classroom';
}

class _CommentApi {
  final String comment = '/v1/comments';
  final String voteComment = '/v1/comments/vote';
}

class _PostApi {
  final String post = '/v1/posts';
  final String postInClassroom = '/v1/posts/posts-by-classroom';
  final String votePost = '/v1/posts/vote';
}

class _ClassroomApi {
  final String classroom = '/v1/classrooms';
  final String removeUserInClassroom =
      '/v1/classrooms/remove-users-in-classroom';
  final String addUserInClassroom = '/v1/classrooms/join-users';
  final String listClassroomOfUser = '/v1/classrooms/classrooms-by-user';
}

class _UserApi {
  final String removeClassroomUser = '/v1/users/remove-classroom-from-user';
  final String joinClassroomUser = '/v1/users/join-classrooms';
  final String user = '/v1/users';
  final String userInClassroom = '/v1/users/users-by-classroom';
}

class _AuthApi {
  final String loginAuth = '/v1/auth/login';
  final String registerAuth = '/v1/auth/register';
  final String getInfoAuth = '/v1/auth/me';
}
