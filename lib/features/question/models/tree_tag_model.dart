class TreeTagModel {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? tag;
  String? parentId;
  String? type;
  List<TreeTagModel> children;

  TreeTagModel({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.tag,
    this.parentId,
    this.type,
    this.children = const [],
  });

  static TreeTagModel empty() => TreeTagModel(children: []);

  TreeTagModel convertFromList(List<Map<String, dynamic>> data) {
    Map<String, TreeTagModel> nodeMap = {};

    // Create TreeNode instances from the data
    for (var item in data) {
      var node = TreeTagModel(
        createdAt: item['createdAt'],
        updatedAt: item['updatedAt'],
        id: item['id'],
        tag: item['tag'],
        parentId: item['parentId'],
        type: item['type'],
        children: [],
      );
      nodeMap[item['id']] = node;
    }

    // Build the tree structure by linking parent and child nodes
    for (var item in data) {
      var parentId = item['parentId'];
      if (parentId != null) {
        var parent = nodeMap[parentId];
        var child = nodeMap[item['id']];
        if (parent != null && child != null) {
          parent.children.add(child);
        }
      }
    }

    // Find the root node (the one without a parent)
    for (var node in nodeMap.values) {
      if (node.parentId == null) {
        return node;
      }
    }

    return TreeTagModel.empty(); // Return null if no root node is found
  }
}
