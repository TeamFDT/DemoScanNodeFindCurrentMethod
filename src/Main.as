package {
	import fdt.ast.IFdtAstNode;

	import swf.bridge.FdtEditorContext;
	import swf.bridge.IFdtActionBridge;
	import swf.plugin.ISwfActionPlugin;

	import flash.display.Sprite;
	import flash.utils.Dictionary;

	[FdtSwfPlugin(name="NodeTest", pluginType="action", toolTip="Some tooltip")]
	public class Main extends Sprite implements ISwfActionPlugin {
		private var _bridge : IFdtActionBridge;
		private var currentFile : String;
		private var context : FdtEditorContext;

		public function Main() {
			FdtSwfPluginIcon;
		}

		public function callEntryAction(entryId : String) : void {
		}

		public function createProposals(ec : FdtEditorContext) : void {
			_bridge.offerProposal("MyProposalId", "MyCoolIcon", "Scan & Trace Nodes", "Scanning nodes and tracing to cosole...", onSelection);
		}

		private function onSelection(id : String, ec : FdtEditorContext) : void {
			_bridge.editor.getCurrentContext().sendTo(this, useContext);
		}

		private function useContext(context : FdtEditorContext) : void {
			this.context = context;
			currentFile = context.currentFile;
			trace("****************************************");
			trace('context.currentLineOffset: ' + (context.currentLineOffset));
			trace('context.selectionOffset: ' + (context.selectionOffset));
			trace("****************************************");
			_bridge.model.fileAst(currentFile).sendTo(this, useAst);
		}

		private function useAst(root : IFdtAstNode) : void {
			var demo_visitor : DemoNodeVisitor = new DemoNodeVisitor(context);
			demo_visitor.visit(root);
			// _bridge.model.fileDocumentModify(currentFile, demo_visitor.edits).sendTo(null, null);
		}

		public function init(bridge : IFdtActionBridge) : void {
			_bridge = bridge;
		}

		public function dialogClosed(dialogInstanceId : String, result : String) : void {
		}

		public function setOptions(options : Dictionary) : void {
		}
	}
}
