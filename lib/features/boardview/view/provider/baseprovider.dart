abstract class BaseKanbanBoardProvider<T> {
  T onAdd();
  T onDelet();
  void onUpdate();
  void onModelChange();
}
