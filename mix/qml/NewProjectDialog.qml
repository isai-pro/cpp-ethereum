import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2

Window {

	modality: Qt.WindowModal

	width: 640
	height: 280

	visible: false

	property alias projectTitle : titleField.text
	readonly property string projectPath : "file://" + pathField.text
	signal accepted

	function open() {
		visible = true;
		titleField.focus = true;
	}

	function close() {
		visible = false;
	}

	GridLayout {
		id: dialogContent
		columns: 2
		anchors.fill: parent
		anchors.margins: 10
		rowSpacing: 10
		columnSpacing: 10

		Label {
			text: qsTr("Title")
		}
		TextField {
			id: titleField
			focus: true
			Layout.fillWidth: true
		}

		Label {
			text: qsTr("Path")
		}
		RowLayout {
			TextField {
				id: pathField
				Layout.fillWidth: true
			}
			Button {
				text: qsTr("Browse")
				onClicked: createProjectFileDialog.open()
			}
		}

		RowLayout
		{
			anchors.bottom: parent.bottom
			anchors.right: parent.right;

			Button {
				enabled: titleField.text != "" && pathField.text != ""
				text: qsTr("Ok");
				onClicked: {
					close();
					accepted();
				}
			}
			Button {
				text: qsTr("Cancel");
				onClicked: close();
			}
		}
	}

	FileDialog {
		id: createProjectFileDialog
		visible: false
		title: qsTr("Please choose a path for the project")
		selectFolder: true
		onAccepted: {
			var u = createProjectFileDialog.fileUrl.toString();
			if (u.indexOf("file://") == 0)
				u = u.substring(7, u.length)
			pathField.text = u;
		}
	}
}
