import 'package:mason/mason.dart';

void run(HookContext context) {
  final template = context.vars['template'];

  context.vars = {
    ...context.vars,
    'use_big_fact': template == 'big-fact',
    'use_blank': template == 'blank',
    'use_custom': template == 'custom',
    'use_image': template == 'image',
    'use_split': template == 'split',
    'use_template': template == 'template',
    'use_title': template == 'title',
  };
}
