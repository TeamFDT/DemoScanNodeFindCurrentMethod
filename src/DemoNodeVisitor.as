package {
	import fdt.FdtTextEdit;
	import fdt.ast.FdtAstFunction;
	import fdt.ast.FdtAstVarDec;
	import fdt.ast.IFdtAstNode;
	import fdt.ast.util.FdtAstVisitor;

	import swf.bridge.FdtEditorContext;

	public class DemoNodeVisitor extends FdtAstVisitor {
		private var _edits : Vector.<FdtTextEdit> = new Vector.<FdtTextEdit>();
		private var context : FdtEditorContext;

		public function DemoNodeVisitor(context : FdtEditorContext) {
			this.context = context;
		}

		override protected function enterNode(depth : int, parent : IFdtAstNode, name : String, index : int, node : IFdtAstNode) : Boolean {
			if (node) {
				if (is_cursor_inside(node) && node as FdtAstFunction) {
					var current_method : FdtAstFunction = node as FdtAstFunction;
					trace("*******************Inside of (node)*********************");
					trace("I'm in the method where the cursor is! It's name is: ", current_method.name.content);
					trace("The cursor is at: ", context.selectionOffset, "and the method ends at: ", node.offset + node.length);
					var params : Vector.<IFdtAstNode> = current_method.parameters.params;
					if (params.length) {
						trace("It has: ", current_method.parameters.params.length, " parameters");
						trace("The first param is named: ", FdtAstVarDec(params[0]).name.content);
						trace("The first param's type is: ", FdtAstVarDec(params[0]).type.content);

					} else {
						trace("It has no params");
					}
				}
			}
			else{
				trace("****************************************");
				trace("The cursor is not in a method");
				
			}
			return true;
		}

		private function is_cursor_inside(node : IFdtAstNode) : Boolean {
			return node.offset < context.selectionOffset && (context.selectionOffset < (node.offset + node.length));
		}

		public function get edits() : Vector.<FdtTextEdit> {
			return _edits;
		}
	}
}
