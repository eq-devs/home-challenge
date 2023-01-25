// ignore_for_file: prefer_const_constructors

import '../models/models.dart';

class Datas {
  static KanbanModel kanbanModel = KanbanModel(
      addTime: 1234, children: _getColumns(), id: 123, title: 'Titlee');
  static List<KColumn> _getColumns() {
    return List.from([
      KColumn(
        title: 'To Do',
        children: const [
          KTask(title: 'ToDo 1', subtitle: 'Hello'),
          KTask(title: 'ToDo 2', subtitle: 'Hello'),
        ],
      ),
      KColumn(
        title: 'In Progress',
        children: const [
          KTask(title: 'ToDo 3', subtitle: 'Hello'),
        ],
      ),
      KColumn(
        title: 'Done',
        children: const [
          KTask(title: 'ToDo 4', subtitle: 'Hello'),
          KTask(title: 'ToDo 5', subtitle: 'Hello'),
        ],
      )
    ]);
  }
}
