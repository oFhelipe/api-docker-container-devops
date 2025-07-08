import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { TaskService } from './task.service';
import { Task } from './task.entity';

@Controller('/task')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Post()
  async create(@Body() createTaskDto: Partial<Task>) {
    return await this.taskService.create(createTaskDto);
  }

  @Get()
  async getAll() {
    return await this.taskService.findAll();
  }

  @Get('/:id')
  async getOne(@Param('id') id: number) {
    return await this.taskService.findOne(id);
  }
}
