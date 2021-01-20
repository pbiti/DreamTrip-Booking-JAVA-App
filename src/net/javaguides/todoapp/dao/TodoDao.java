package net.javaguides.todoapp.dao;

import java.sql.SQLException;
import java.util.List;

import net.javaguides.todoapp.model.Todo;

public interface TodoDao {

	void insertTodo(Todo todo) throws SQLException;

	Todo selectTodo(long todoId, String username);

	List<Todo> selectAllTodos();
	
    List<Todo> Todos_after_edit(Todo todo, String username);
	
	List<Todo> selectTodoByuname(String todousername);

	boolean deleteTodo(int id) throws SQLException;

	boolean updateTodo(Todo todo) throws SQLException;

}